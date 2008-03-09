/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.controller
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

	public class CreateBookCommand extends SimpleCommand implements ICommand, IResponder
	{
		
		override public function execute(notification:INotification):void
		{ 
			var delegate:LibraryDelegate = new LibraryDelegate(this);
			delegate.createBook(notification.getBody() as Book);
		}
		
		public function result(data:Object):void
		{
			var createdBook:Book = data.result as Book;
			var proxy:BookProxy = facade.retrieveProxy(BookProxy.NAME) as BookProxy;
			proxy.books.addItem(createdBook);
			sendNotification(ApplicationFacade.BOOK_SELECTED, createdBook);
			
		}
		
		public function fault(info:Object):void
		{
			Alert.show((info as FaultEvent).toString());
		}
		
	}
}