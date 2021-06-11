using Komunalka.Infrastructure;
using Komunalka.Models;
using KomunalkaDAL.DbModels;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace Komunalka.ViewModels {
	class MainViewModel : NotifyPropertyChanged {
		KomunalkaContext context;
		public MainViewModel() {
			Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-en");
			context = new KomunalkaContext();
			TotalSum.Tse += TotS;
			CurrConfig = GetCurrConfig();
			StatisticAddressList = GetAddressList();
			StatisticAddressList_SelectedItem = StatisticAddressList
												.Where(a => a.AddressId == CurrConfig
																			.Where(b => b.Attribute == "AddressId")
																			.FirstOrDefault()
																			.Value)
												.FirstOrDefault();
			NewData_AddressList = GetAddressList();
			NewDataAddressList_SelectedItem = NewData_AddressList
												.Where(a => a.AddressId == CurrConfig
																			.Where(b => b.Attribute == "AddressId")
																			.FirstOrDefault()
																			.Value)
												.FirstOrDefault();
			MonthList = GetMonthList();
			YearList = GetYearList();
			if (DateTime.Now.Month == 1)
				PaymentMonthId = 11;
			else
				PaymentMonthId = DateTime.Now.Month - 2;
			if (DateTime.Now.Month == 1)
				PaymentYearId = 0;
			else
				PaymentYearId = 1;
			CommandSave = new CustomCommand(CommandSave_Execute,CommandSave_CanExecute);
			CommandReset = new CustomCommand(CommandReset_Execute);
		}

		private Addresses _NewDataAddressList_SelectedItem;
		public Addresses NewDataAddressList_SelectedItem {
			get => _NewDataAddressList_SelectedItem;
			set {
				_NewDataAddressList_SelectedItem = value;
				Mod_NewDataCollect = GetNewDataCollect(value.AddressId);
				TotalSum.NewSum();
				OnPropertyChanged();
			}
		}
		private Addresses _StatisticAddressList_SelectedItem;
		public Addresses StatisticAddressList_SelectedItem {
			get => _StatisticAddressList_SelectedItem;
			set {
				_StatisticAddressList_SelectedItem = value;
				HP = GetHistoryPayments(value.AddressId);
				OnPropertyChanged();
			}
		}
		private decimal _TotalSumToPay;
		public string TotalSumToPay {
			get => $"{_TotalSumToPay} грн.";
			set {
				_TotalSumToPay = Convert.ToDecimal(value);
				OnPropertyChanged();
			}
		}
		private int _PaymentMonthId;
		public int PaymentMonthId {
			get => _PaymentMonthId;
			set {
				_PaymentMonthId = value;
				OnPropertyChanged();
			}
		}
		private int _PaymentYearId;
		public int PaymentYearId {
			get => _PaymentYearId;
			set {
				_PaymentYearId = value;
				OnPropertyChanged();
			}
		}
		private List<string> _MonthList;
		public List<string> MonthList {
			get => _MonthList;
			set {
				_MonthList = value;
				OnPropertyChanged();
			}
		}
		private List<int> _YearList;
		public List<int> YearList {
			get => _YearList;
			set {
				_YearList = value;
				OnPropertyChanged();
			}
		}

		private ObservableCollection<CurrentConfig> _CurrConfig;
		public ObservableCollection<CurrentConfig> CurrConfig {
			get => _CurrConfig;
			set {
				_CurrConfig = value;
				OnPropertyChanged();
			}
		}
		private ObservableCollection<HistoryPayments> _HP;
		public ObservableCollection<HistoryPayments> HP {
			get => _HP;
			set {
				_HP = value;
				OnPropertyChanged();
			}
		}
		private ObservableCollection<Mod_NewData> _Mod_NewDataCollect;
		public ObservableCollection<Mod_NewData> Mod_NewDataCollect {
			get => _Mod_NewDataCollect;
			set {
				_Mod_NewDataCollect = value;
				OnPropertyChanged();
			}
		}
		private ObservableCollection<Addresses> _AddressList;
		public ObservableCollection<Addresses> NewData_AddressList {
			get => _AddressList;
			set {
				_AddressList = value;
				OnPropertyChanged();
			}
		}
		private ObservableCollection<Addresses> _StatisticAddressList;
		public ObservableCollection<Addresses> StatisticAddressList {
			get => _StatisticAddressList;
			set {
				_StatisticAddressList = value;
				OnPropertyChanged();
			}
		}

		private ObservableCollection<CurrentConfig> GetCurrConfig(){
			return new ObservableCollection<CurrentConfig>(context.Database.SqlQuery<CurrentConfig>(@"
				SELECT Attribute, Value
					FROM CurrentConfig
			").ToList());
		}
		private ObservableCollection<HistoryPayments> GetHistoryPayments(int? addrId=null){
			if (addrId == null)
				addrId = CurrConfig.Where(a => a.Attribute == "AddressId").First().Value;
			List<HistoryPayments> list = new List<HistoryPayments>();
			//нумерация и даты
			List<string> d = context.Database.SqlQuery<string>($@"
				SELECT RowId FROM (
					SELECT CAST(ROW_NUMBER() OVER(ORDER BY PayDate DESC) AS NVARCHAR(10)) RowId,
							CAST(PayDate AS NVARCHAR(10)) PayDate
						FROM PayDates
						WHERE AddressId={addrId}) q
			").ToList();
			list.Add(new HistoryPayments { Header = "№з/п", Data = d });
			d = context.Database.SqlQuery<string>($@"
					SELECT CAST(PayDate AS NVARCHAR(10)) PayDate
						FROM PayDates
						WHERE AddressId={addrId}
						ORDER BY PayDate DESC
			").ToList();
			list.Add(new HistoryPayments { Header = "Дата", Data = d });
			//список услуг
			List<Services> serv = context.Database.SqlQuery<Services>($@"
				SELECT s.ServiceId,s.ServiceName,
						ISNULL(s.ServiceAcronym,s.ServiceName) ServiceAcronym,
						s.TableName,s.MeasureUnit
					FROM Services s
						JOIN AddressActiveServices a ON(a.ServiceId=s.ServiceId)
					WHERE s.Active=1 AND a.AddressId={addrId}
			").ToList();
			foreach (Services item in serv) {
			//данные
				List<string> data = context.Database.SqlQuery<string>($@"
					SELECT ToPay 
						FROM (SELECT p.PayDate
									,ISNULL(CAST(Sum(t.Sum+t.SubscriberFee) AS NVARCHAR(20)),'-') ToPay
								FROM {item.TableName} t
									RIGHT JOIN PayDates p ON t.ValueDate=p.PayDate
								WHERE p.AddressId={addrId}
								GROUP BY p.PayDate
							) q
						ORDER BY PayDate DESC
				").ToList();
				list.Add(new HistoryPayments { Name = item.TableName, Header = item.ServiceAcronym, Data=data });
			}
			return new ObservableCollection<HistoryPayments>(list);
		}
		private ObservableCollection<Mod_NewData> GetNewDataCollect(int? addrId=null){
			if (addrId == null)
				addrId = CurrConfig.Where(a => a.Attribute == "AddressId").First().Value;
			return new ObservableCollection<Mod_NewData>(context.Database.SqlQuery<Mod_NewData>(
				"EXECUTE sp_GetNewDataCollect @AddressId;",
				new SqlParameter("@AddressId", addrId == null ? 0 : addrId)
			).ToList());
		}
		private ObservableCollection<Addresses> GetAddressList() {
			return new ObservableCollection<Addresses>(context.Database.SqlQuery<Addresses>(@"
				SELECT AddressId
						,CONCAT(City,', ',Street,', б. ',House,IIF(ISNULL(Flat,'')='','',CONCAT(', кв.',Flat))) AddressValue
					FROM Addresses
					WHERE Active=1
			").ToList());
		}
		private List<string> GetMonthList(){
			List<string> list = new List<string>(){
				"січень","лютий","березень","квітень",
				"травень","червень","липень","серпень",
				"вересень","жовтень","листопад","грудень" };
			return list;
		}
		private List<int> GetYearList(){
			List<int> list = new List<int>(){
				DateTime.Now.Year-1,
				DateTime.Now.Year
			};
			return list;
		}
		private void TotS(){
			if (Mod_NewDataCollect == null)
				TotalSumToPay = "0";
			else
				TotalSumToPay = Convert.ToString(Mod_NewDataCollect.Sum(a => a.PaySum));
		}

		public ICommand CommandSave { get; set; }
		private void CommandSave_Execute(object parametr) {
			int? addrId = CurrConfig.Where(b => b.Attribute == "AddressId")
									.FirstOrDefault()
									.Value;
			context.Database.ExecuteSqlCommand($@"
				EXECUTE sp_AddPayDate {addrId};
			");
			foreach (Mod_NewData item in Mod_NewDataCollect) {
				if(item.Active.ToLower() == "true"){
					context.Database.ExecuteSqlCommand(@"
						EXECUTE sp_AddNewData 
							@AddressId,@PaidMonth,@PaidYear,@ServiceId,
							@Value,@Difference,@Sum,@SubscribFee,@Comment;",
						new SqlParameter("@AddressId", NewDataAddressList_SelectedItem.AddressId),
						new SqlParameter("@PaidMonth", PaymentMonthId + 1),
						new SqlParameter("@PaidYear", YearList[PaymentYearId]),
						new SqlParameter("@ServiceId", item.ServiceId),
						new SqlParameter("@Value", item.CounterValueCurrent),
						new SqlParameter("@Difference", item.DifferenceValue),
						new SqlParameter("@Sum", item.DifferenceSum),
						new SqlParameter("@SubscribFee", item.SubscriberFeeSum),
						new SqlParameter("@Comment", $"'{item.Comment}'")
					);
				}
			}
			CommandReset_Execute(null);
		}
		private bool CommandSave_CanExecute(object parametr) {
			int? addrId = CurrConfig.Where(b => b.Attribute == "AddressId")
									.FirstOrDefault()
									.Value;
			if (addrId == null || addrId == 0)
				return false;
			int count = Mod_NewDataCollect.Count(a => a.Active.ToLower() == "true");
			if (count == 0)
				return false;
			if (_TotalSumToPay == 0)
				return false;
			return true;
		}
		public ICommand CommandReset { get; set; }
		private void CommandReset_Execute(object parametr) {
			foreach (Mod_NewData item in Mod_NewDataCollect) {
				item.CounterValueCurrent = String.Empty;
				item.SubscriberFeeSum = 0;
				item.Active = "True";
			}
		}





















	}
}
