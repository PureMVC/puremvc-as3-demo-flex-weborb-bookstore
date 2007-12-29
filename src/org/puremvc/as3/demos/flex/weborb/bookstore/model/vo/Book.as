/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.model.vo
{
	
	[RemoteClass(alias="Book")]	
	[Bindable]
	public class Book
	{

		public var idbook:int;
		public var idauthor:int;
		public var title:String;
		public var price:Number;
		public var date:String;
		public var is_public:Boolean;


		public function Book()
		{
			
		}
		
	}
}