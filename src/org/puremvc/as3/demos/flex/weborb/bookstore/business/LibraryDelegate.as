/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.business
{
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;	

	public class LibraryDelegate
	{
		
		private var service :RemoteObject;
		private var responder:IResponder;
		
		public function LibraryDelegate(pResponder:IResponder)
		{
			
			service = new RemoteObject();
	    	service.endpoint="http://localhost:8888/formation/Weborb/index.php";
	    	service.destination="GenericDestination";
	    	service.makeObjectsBindable=true;
	    	service.showBusyCursor=true;
	    	service.source="LibraryService";
			
			responder = pResponder;
		}
		
		public function getBooks():void
		{
			var call:Object = service.getBooks();
			call.addResponder(responder);
		}

		public function getBook(id:int):void
		{
			var call:Object = service.getBook(id);
			call.addResponder(responder);
		}

		public function createBook(book:Book):void
		{
			var call:Object = service.createBook(book);
			call.addResponder(responder);
		}

		public function updateBook(book:Book):void
		{
			var call:Object = service.updateBook(book);
			call.addResponder(responder);
		}

		public function deleteBook(book:Book):void
		{
			var call:Object = service.deleteBook(book);
			call.addResponder(responder);
		}


	}
}