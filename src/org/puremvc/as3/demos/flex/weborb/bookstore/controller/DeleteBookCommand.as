/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.control
{
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import org.puremvc.as3.demos.flex.weborb.bookstore.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.bookstore.business.LibraryDelegate;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.BookProxy;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;
	

	public class DeleteBookCommand extends SimpleCommand implements ICommand, IResponder
	{
		
		private var bookToDelete:Book;
		
		override public function execute(notification:INotification):void
		{
			bookToDelete = notification.getBody() as Book ;
			var delegate:LibraryDelegate = new LibraryDelegate(this);
			delegate.deleteBook(bookToDelete);
			
		}
		
		public function result(data:Object):void
		{
			
			var proxy:BookProxy = facade.retrieveProxy(BookProxy.NAME) as BookProxy;
			proxy.removeBook(bookToDelete);
			sendNotification(ApplicationFacade.BOOK_DELETED);
			
		}
		
		public function fault(info:Object):void
		{
			Alert.show((info as FaultEvent).toString());
		}
		
	}
}