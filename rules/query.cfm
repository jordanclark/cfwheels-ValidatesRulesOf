<cfif NOT isQuery( arguments.value )>
	<cfset arguments.message = "is not a valid query object">
</cfif>

