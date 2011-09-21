<cfparam name="arguments.zipDivider" type="string" default="-">
<cfparam name="arguments.autoFormat" type="boolean" default="true">

<cfif arguments.autoFix>
	<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9]", "", "all" )>
	<cfif len( arguments.value ) GT 5>
		<cfset arguments.value = left( arguments.value, 9 )>
	<cfelse>
		<cfset arguments.value = left( arguments.value, 5 )>
	</cfif>
</cfif>

<cfif reFind( "^[0-9]{5}$", arguments.value )>
	<!--- golden --->

<cfelseif reFind( "^[0-9]{9}$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFormat>
		<cfset arguments.value = left( arguments.value, 5 ) & arguments.zipDivider & right( arguments.value, 4 )>
	</cfif>
	
<cfelse>
	<cfif arguments.autoFix>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9]", "", "all" )>
		<cfif len( arguments.value ) GT 5>
			<cfset arguments.value = left( arguments.value, 9 )>
		<cfelse>
			<cfset arguments.value = left( arguments.value, 5 )>
		</cfif>
	</cfif>
	<cfset arguments.message = "is invalid, it must be in either ""12345"" or ""12345#arguments.zipDivider#6789"" format">
</cfif>

