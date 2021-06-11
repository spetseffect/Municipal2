namespace KomunalkaDAL.DbModels {
	using System;
	using System.Data.Entity;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Linq;

	public partial class KomunalkaContext : DbContext {
		public KomunalkaContext()
			: base("name=KomunalkaContext") {
		}
	}
}
