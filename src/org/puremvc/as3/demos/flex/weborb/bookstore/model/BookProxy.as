/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.model
{
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.Book;

	public class BookProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "BookProxy";
		
		public function BookProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, new ArrayCollection() );
		}
		
		public function get books():ArrayCollection
		{
			return data as ArrayCollection ;
		}
		
		
		public function replaceBook(pNewBook:Book):void
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
		
		public function removeBook(pBook:Book):void
		{
			var i:int = books.getItemIndex(pBook);
			if(i!=-1) books.removeItemAt(i);
			else trace("Book not found")
			
		}
		
	}
}