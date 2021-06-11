namespace Komunalka.Infrastructure {
	public static class TotalSum {
		public delegate void TS();
		public static event TS Tse;
		public static void NewSum(){
			Tse?.Invoke();
		}
	}
}
