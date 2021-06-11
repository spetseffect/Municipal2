using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Komunalka.Models {
	public class Services {
		public int ServiceId { get; set; }
		public string ServiceName { get; set; }
		public string ServiceAcronym { get; set; }
		public string TableName { get; set; }
		public string MeasureUnit { get; set; }
	}
}
