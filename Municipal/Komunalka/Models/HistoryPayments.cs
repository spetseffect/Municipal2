using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Komunalka.Models{
    public class HistoryPayments {
        public string Name { get; set; }
        public string Header { get; set; }
        public List<string> Data { get; set; }
    }
}
