/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.model
{
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.demos.flex.weborb.bookstore.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.business.LibraryDelegate;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy; 

	public class BookProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "BookProxy";

		
		private var bookToDelete:Book;
		
		public function BookProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, new ArrayCollection() );
		}
		
		public function get books():ArrayCollection
		{
			return data as ArrayCollection ;
		}
		
		public function getBooks():void
		{
			var delegate:LibraryDelegate = new LibraryDelegate(new Responder(onGetBooksResult, onFault));
			delegate.getBooks();
		}
		private function onGetBooksResult(pResultEvt:ResultEvent):void
		{
			books.source = pResultEvt.result as Array;
		}
		
		public function deleteBook(pBook:Book):void
		{
			bookToDelete = pBook ;			
			var delegate:LibraryDelegate = new LibraryDelegate(new Responder(onDeleteBookResult, onFault));
			delegate.deleteBook(bookToDelete);
		}
		private function onDeleteBookResult(pResultEvt:ResultEvent):void
		{
			removeBook(bookToDelete);
			bookToDelete = null;
			sendNotification(ApplicationFacade.BOOK_DELETED);
		}
		private function removeBook(pBook:Book):void
		{
			var i:int = books.getItemIndex(pBook);
			if(i!=-1) books.removeItemAt(i);
			else trace("Book not found");	
		}
		
		public function updateBook(pBook:Book):void
		{
			var delegate:LibraryDelegate = new LibraryDelegate(new Responder(onUpdateBookResult, onFault));
			delegate.updateBook(pBook);			
		}
		private function onUpdateBookResult(pResultEvt:ResultEvent):void
		{
			var returnedBook:Book = pResultEvt.result as Book;
			replaceBook(returnedBook);
			sendNotification(ApplicationFacade.BOOK_SELECTED, returnedBook);
		}
				
		private function replaceBook(pNewBook:Book):void
		{
			var id:int = pNewBook.idbook;
			
			for ( var i:int =0 ; i < books.length ; i++)
			{
				var book:Book = books.getItemAt(i) as Book;
				if( book.idbook == id){
					books.setItemAt(pNewBook, i);
					return ;
				}
			}
		}
		
		
		public function createBook(pBook:Book):void
		{
			var delegate:LibraryDelegate = new LibraryDelegate(new Responder(onCreateBookResult, onFault));
			delegate.createBook(pBook);			
		}
		private function onCreateBookResult(pResultEvt:ResultEvent):void
		{
			var returnedBook:Book = pResultEvt.result as Book;
			books.addItem( returnedBook);
			sendNotification(ApplicationFacade.BOOK_SELECTED, returnedBook);
		}
		
				
		private function onFault(pFaultEvt:FaultEvent):void
		{
			Alert.show(pFaultEvt.fault.faultString, "Error");
		}		
		
	}
}