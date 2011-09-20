<cfparam name="arguments.postalDivider" type="string" default=" ">
<cfparam name="arguments.autoFormat" type="boolean" default="true">

<cfif arguments.autoFix>
	<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9#arguments.postalDivider#]", "", "all" )>
</cfif>

<cfif NOT reFindNoCase( "^[a-ceghj-npr-tvxy][0-9][a-ceghj-npr-tv-z]#arguments.postalDivider#[0-9][a-ceghj-npr-tv-z][0-9]$", arguments.value )>
	<cfif attributes.mutable AND NOT attributes.autoFix>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9#arguments.postalDivider#]", "", "all" )>
	</cfif>
	<cfset arguments.message = "is not valid, they must be in the ""X0X#arguments.postalDivider#0X0"" format">

<cfelseif arguments.autoFormat AND arguments.mutable>
	<cfset arguments.value = uCase( left( arguments.value, 3 ) & arguments.postalDivider & right( arguments.value, 3 ) )>
</cfif>
