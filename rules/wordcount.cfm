<cfparam name="arguments.wordCount" type="string" default="">
<cfparam name="arguments.minWords" type="string" default="">
<cfparam name="arguments.maxWords" type="string" default="">
<cfparam name="arguments.wordRespace" type="boolean" default="false">

<cfif isNumeric( arguments.wordCount )>
	<cfset arguments.minWords = "">
	<cfset arguments.maxWords = "">
<cfelseif listLen( arguments.wordCount, "-" ) IS 2>
	<cfset arguments.minWords = replace( listGetAt( arguments.wordCount, 1, "-" ), "N", "" )>
	<cfset arguments.maxWords = replace( listGetAt( arguments.wordCount, 2, "-" ), "N", "" )>
</cfif>

<cfif arguments.mutable AND arguments.wordRespace>
	<cfset arguments.value = trim( reReplace( arguments.value, "\s+", " ", "all" ) )>
	<cfset wordCount = listLen( arguments.value, " " )>
<cfelse>
	<cfset wordCount = listLen( trim( reReplace( arguments.value, "\s+", " ", "all" ) ), " " )>
</cfif>

<cfif len( arguments.maxWords ) AND len( arguments.minWords )>
	<cfif wordCount GT arguments.maxWords OR wordCount LT arguments.minWords>
		<cfset arguments.message = "must be between #arguments.minWords# to #arguments.maxWords# words long">
	</cfif>

<cfelseif len( arguments.maxWords )>
	<cfif wordCount GT arguments.maxWords>
		<cfset arguments.message = "must be no more than #arguments.maxWords# words long">
	</cfif>

<cfelseif len( arguments.minWords )>
	<cfif wordCount LT arguments.minWords>
		<cfset arguments.message = "must be at least #arguments.minWords# words long">
	</cfif>

<cfelseif len( arguments.wordCount )>
	<cfif wordCount IS NOT arguments.wordCount>
		<cfset arguments.message = "must be exactly #arguments.wordCount# words long">
	</cfif>
</cfif>

