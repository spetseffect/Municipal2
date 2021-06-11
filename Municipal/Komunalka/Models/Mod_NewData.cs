using Komunalka.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Komunalka.Models {
	public class Mod_NewData : NotifyPropertyChanged {
		public int ServiceId { get; set; }
		public string ServiceName { get; set; }
		public string Active {
			get => _active;
			set {
				_active = value;
				CounterValueCurrent = String.Empty;
				SubscriberFeeSum = 0;
				OnPropertyChanged();
			}
		}
		public string DifferenceVisibility { get; set; }
		public decimal? DifferenceValue {
			get => _diff;
			set {
				_diff = value;
				if (_current < 0 || _current==null)
					DifferenceSum = 0;
				else {
					decimal p, d;
					if (_current >= (decimal)_prev)
						d = (decimal)_current - (decimal)_prev;
					else
						d = (decimal)_current + 100000m - (decimal)_prev;
					if (_tv >= 0 && d > _tv)
						p = (decimal)_tv * (decimal)_rate1 + (d - (decimal)_tv) * (decimal)_rate2;
					else
						p = d * (decimal)_rate1;
					DifferenceSum = p;
				}
				OnPropertyChanged();
			}
		}
		public decimal? Rate1 {
			get => _rate1;
			set {
				_rate1 = value;
				OnPropertyChanged();
			}
		}
		public decimal? Rate2 {
			get => _rate2;
			set {
				_rate2 = value;
				OnPropertyChanged();
			}
		}
		public string SlashBetweenRates { get; set; }
		public string ThresholdValueVisibility { get; set; }
		public decimal? ThresholdValue {
			get => _tv;
			set {
				_tv = value;
				OnPropertyChanged();
			}
		}
		public decimal DifferenceSum {
			get => _diffsum;
			set {
				_diffsum = value;
				OnPropertyChanged();
			}
		}
		public string MeasureUnit { get; set; }
		public decimal PaySum {
			get => _pay;
			set {
				_pay = value;
				TotalSum.NewSum();
				OnPropertyChanged();
			}
		}
		public string CounterVisibility { get; set; }
		public decimal? CounterValuePrev {
			get => _prev;
			set {
				_prev=value;
				OnPropertyChanged();
			}
		}
		public string CounterValueCurrent {
			get {
				if (_current==null)
					return String.Empty;
				else
					return Convert.ToString(_current);
			}
			set {
				if (value == String.Empty) {
					_current = null;
					DifferenceValue = 0;
				}
				else {
					_current = Convert.ToDecimal(value);
					decimal p, d;
					if ((decimal)_current >= (decimal)_prev)
						d = (decimal)_current - (decimal)_prev;
					else
						d = (decimal)_current + 100000m - (decimal)_prev;
					if (_tv >= 0 && d > _tv)
						p = (decimal)_tv * (decimal)_rate1 + (d - (decimal)_tv) * (decimal)_rate2;
					else
						p = d * (decimal)_rate1;
					DifferenceValue = d;
					DifferenceSum = p;
				}
				PaySum = Convert.ToDecimal(_feesum) /*_feesum.HasValue?(decimal)_feesum:0*/ + _diffsum;
				OnPropertyChanged();
			}
		}
		public string SubscriberFeeVisibility { get; set; }
		public decimal? SubscriberFeeSum {
			get => _feesum;
			set {
				_feesum = value;
				PaySum = (decimal)_feesum + _diffsum;
				OnPropertyChanged();
			}
		}
		public string Comment { get; set; }
		private string		_active;
		private decimal?	_diff;
		private decimal		_pay;
		private decimal?	_prev;
		private decimal?	_current;
		private decimal		_diffsum;
		private decimal?	_feesum;
		private decimal?	_rate1;
		private decimal?	_rate2;
		private decimal?	_tv;//ThresholdValue
	}
}
