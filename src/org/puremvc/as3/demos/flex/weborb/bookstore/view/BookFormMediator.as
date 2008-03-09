/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.demos.flex.weborb.bookstore.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.view.components.*;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BookFormMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = 'BookFormMediator';
		
		public function BookFormMediator(viewComponent:BookForm)
		{
			super(NAME, viewComponent);
			bookForm.addEventListener( BookForm.EVENT_UPDATE, onUpdate );
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
		
		private function get bookForm():BookForm{
			return viewComponent as BookForm;
		}		
		
		private var bookProxy:BookProxy;
	}
}