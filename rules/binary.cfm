<cfif NOT isBinary( arguments.value )>
	<cfset arguments.message = "is not a valid binary object">
</cfif>

