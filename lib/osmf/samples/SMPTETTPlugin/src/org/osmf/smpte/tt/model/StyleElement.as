/***********************************************************
 * 
 * Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
 *
 * *********************************************************
 * The contents of this file are subject to the Berkeley Software Distribution (BSD) Licence
 * (the "License"); you may not use this file except in
 * compliance with the License. 
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 *
 * The Initial Developer of the Original Code is Adobe Systems Incorporated.
 * Portions created by Adobe Systems Incorporated are Copyright (C) 2011 Adobe Systems
 * Incorporated. All Rights Reserved.
 **********************************************************/
package org.osmf.smpte.tt.model
{
	import org.osmf.smpte.tt.model.metadata.MetadataElement;
	
	public class StyleElement extends TimedTextElementBase
	{
		public function StyleElement()
		{
		}
		
		//{ region Validity
		/*
		<style
		style = IDREFS
		xml:id = ID
		xml:lang = string
		xml:space = (default|preserve)
		{any attribute in TT Style namespace ...}
		{any attribute in TT Style Extension namespace ...}
		{any attribute not in default or any TT namespace ...}>
		Content: Metadata.class*
		</style>
		*/
		/**
		 * Check valisity of style element attributes
		 */
		protected override function validAttributes():void
		{
			validateAttributes(false, false, true, false, false, false);
		}
		
		/**
		 * Check valisity of style element content model
		 */
		protected override function validElements():void
		{
			var child:uint = 0;
			
			//{ region Allow arbitrary metadata
			while ((child < children.length)
				&& ((children[child] is org.osmf.smpte.tt.model.MetadataElement) 
					|| (children[child] is org.osmf.smpte.tt.model.metadata.MetadataElement)))
			{
				child++;
			}
			//} endregion
			
			//{ region Ensure no other element is present
			if (children.length != child)
			{
				error(children[child] + " is not allowed in " + this + " at position " + child);
			}
			//} endregion
			
			//{ region Check each of the children is individually valid
			for each (var element:TimedTextElementBase in children)
			{
				element.valid();
			}
			//} endregion
		}
		//} endregion
	}
}