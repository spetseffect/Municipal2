﻿using System;
using System.Windows.Input;

namespace Komunalka.Infrastructure
{
	class CustomCommand : ICommand {
		readonly Action<object> _execute;
		readonly Predicate<object> _canExecute;
		public CustomCommand(Action<object> execute) : this(execute, null) { }
		public CustomCommand(Action<object> execute, Predicate<object> canExecute) {
			if (execute == null)
				throw new ArgumentNullException("execute");
			_execute = execute;
			_canExecute = canExecute;
		}
		public event EventHandler CanExecuteChanged {
			add { CommandManager.RequerySuggested += value; }
			remove { CommandManager.RequerySuggested -= value; }
		}
		public bool CanExecute(object parameter) {
			return _canExecute == null ? true : _canExecute.Invoke(parameter);
		}
		public void Execute(object parameter) {
			_execute.Invoke(parameter);
		}
	}
}
