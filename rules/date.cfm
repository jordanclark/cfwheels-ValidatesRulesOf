<cfparam name="arguments.parseDate" type="boolean" default="false">

<cfif arguments.parseDate>
	<cfset arguments.value = parseDateTime( arguments.value )>
</cfif>

<cfif NOT isDate( arguments.value )>
	<cfset arguments.message = "is not a valid date">
</cfif>

