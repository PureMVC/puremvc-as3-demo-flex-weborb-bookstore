/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.view
{
	import org.puremvc.as3.demos.flex.weborb.bookstore.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.BookProxy;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;
	import org.puremvc.as3.demos.flex.weborb.bookstore.view.components.BookForm;
	
	import flash.events.Event;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;

	public class BookFormMediator extends Mediator implements IMediator
	{
		
		private var bookProxy:BookProxy;
		public static const NAME:String = 'BookFormMediator';
		
		
		public function BookFormMediator(viewComponent:Object=null)
		{
			super(viewComponent);
			bookForm.addEventListener( BookForm.EVENT_UPDATE, onUpdate );
		}
		
		
		public function get bookForm():BookForm{
			return viewComponent as BookForm;
		}		
		
		private function onUpdate(pEvt:Event):void
		{
			sendNotification(ApplicationFacade.UPDATE_BOOK, bookForm.editedBook);
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
			ApplicationFacade.BOOK_SELECTED,
			ApplicationFacade.BOOK_DELETED,			
			 ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{

				case ApplicationFacade.BOOK_SELECTED:
					var book:Book = notification.getBody() as Book;
					bookForm.currentBook = book ;
					break;

				case ApplicationFacade.BOOK_DELETED:
					bookForm.currentBook = null ;
					break;
			}			
		}
		
	}
}