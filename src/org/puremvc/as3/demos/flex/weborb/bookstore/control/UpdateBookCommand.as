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
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	import org.puremvc.as3.demos.flex.weborb.bookstore.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.bookstore.business.LibraryDelegate;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.BookProxy;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;
	
	public class UpdateBookCommand extends SimpleCommand implements ICommand, IResponder
	{
		
		override public function execute(notification:INotification):void
		{
			var book:Book = notification.getBody() as Book;
			 
			var delegate:LibraryDelegate = new LibraryDelegate(this);
			delegate.updateBook(book);
			
		}
		
		public function result(data:Object):void
		{
			var updatedBook:Book = data.result as Book;
			var proxy:BookProxy = facade.retrieveProxy(BookProxy.NAME) as BookProxy;
			proxy.replaceBook(updatedBook);			
			sendNotification(ApplicationFacade.BOOK_SELECTED, updatedBook);
		}
		
		public function fault(info:Object):void
		{
			Alert.show( (info as FaultEvent).toString());
		}
		
	}
}