using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Komunalka.Models {
	public class NewData {
		public int AddressId { get; set; }
		public int PaidMonth { get; set; }
		public int PaidYear { get; set; }
		public int ServiceId { get; set; }
		public string Rate1 { get; set; }
		public string Rate2 { get; set; }
		public string Value { get; set; }
		public string Difference { get; set; }
		public decimal Sum { get; set; }
		public decimal SubscribFee { get; set; }
		public string Comment { get; set; }
	}
}
