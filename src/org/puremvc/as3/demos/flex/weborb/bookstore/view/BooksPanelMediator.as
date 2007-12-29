/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.view
{
	import example.ApplicationFacade;
	import example.model.BookProxy;
	import example.model.vo.Book;
	import example.view.components.BooksPanel;
	
	import flash.events.Event;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;

	public class BooksPanelMediator extends Mediator implements IMediator
	{
		
		private var bookProxy:BookProxy;
		public static const NAME:String = 'BooksPanelMediator';

		
		public function BooksPanelMediator(viewComponent:Object)
		{
			super(viewComponent);
			
			booksPanel.addEventListener(BooksPanel.CREATE, onCreate);
			booksPanel.addEventListener(BooksPanel.REMOVE, onDelete);
			booksPanel.addEventListener(BooksPanel.SELECT, onSelect);
			
			bookProxy = facade.retrieveProxy(BookProxy.NAME) as BookProxy ;
			
			booksPanel.books = bookProxy.books;
		}
		
		private function get booksPanel():BooksPanel
		{
			return viewComponent as BooksPanel;
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function onCreate(pEvt:Event):void
		{
			var newBook:Book = new Book();
			newBook.title="New";
			newBook.idauthor=1;
			newBook.date="2008-01-01";
			newBook.price=0;
			newBook.is_public=true;
			
			sendNotification(ApplicationFacade.CREATE_BOOK, newBook);
			
		}
		
		private function onSelect(pEvt:Event):void
		{
			sendNotification(ApplicationFacade.BOOK_SELECTED, booksPanel.selectedBook);
		}
		
		private function onDelete(pEvt:Event):void
		{
			sendNotification(ApplicationFacade.DELETE_BOOK, booksPanel.selectedBook);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.BOOK_SELECTED,
				   ];		
   
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			switch ( notification.getName() )
			{

				case ApplicationFacade.BOOK_SELECTED:
					booksPanel.selectedBook = notification.getBody() as Book;
					break;
			}
					
			
		}
		
	}
	
}