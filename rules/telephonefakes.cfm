<!--- <cfparam name="arguments.exclude" type="boolean" default="true"> --->
<cfparam name="arguments.telephoneFakes" type="string" default="000-000-0000,111-111-1111,222-222-2222,333-333-3333,444-444-4444,555-555-5555,666-666-6666,777-777-7777,888-888-8888,999-999-9999,123-456-7890,012-345-6789,987-654-3210,098-765-4321,111-222-3333">
<cfparam name="arguments.divider" type="string" default="-">

<cfif arguments.divider IS NOT "-">
	<cfset arguments.telephoneFakes = replace( arguments.telephoneFakes, "-", arguments.divider, "all" )>
</cfif>

<cfif listFind( arguments.telephoneFakes, reReplace( arguments.value, "[^0-9]", arguments.divider, "all" ) )>
	<cfset arguments.message = "is not a valid phone number, please don't enter a fake number">
</cfif>
