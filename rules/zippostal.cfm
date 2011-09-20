<cfparam name="arguments.zipDivider" type="string" default=" ">
<cfparam name="arguments.postalDivider" type="string" default=" ">
<cfparam name="arguments.autoFormat" type="boolean" default="true">

<cfif arguments.autoFix>
	<cfset arguments.value = trim( reReplaceNoCase( arguments.value, "[^a-z0-9#arguments.postalDivider#]", "", "all" ) )>
</cfif>

<!--- valid postalcode --->
<cfif reFindNoCase( "^[a-ceghj-npr-tvxy][0-9][a-ceghj-npr-tv-z]#arguments.postalDivider#[0-9][a-ceghj-npr-tv-z][0-9]$", arguments.value )>
	<cfif arguments.autoFormat AND arguments.mutable>
		<cfset arguments.value = uCase( left( arguments.value, 3 ) & arguments.postalDivider & right( arguments.value, 3 ) )>
	</cfif>

<!--- valid zipcode --->
<cfelseif reFindNoCase( "^[0-9]{5,5}(#arguments.zipDivider#[0-9]{4,4})?$", arguments.value )>
	<cfif arguments.autoFormat AND arguments.mutable AND len( arguments.value ) GTE 9>
		<cfset arguments.value = left( arguments.value, 5 ) & arguments.zipDivider & right( arguments.value, 4 )>
	</cfif>

<cfelse>
	<cfif arguments.autoFix>
		<cfset arguments.value = trim( reReplaceNoCase( arguments.value, "[^a-z0-9#arguments.zipDivider#]", "", "all" ) )>	
	</cfif>
	<cfset arguments.message = "is not a valid Zip code or Postal code.<ul><li>Properly formated zip codes are ""12345"" or ""12345#arguments.zipDivider#6789""</li><li>Properly formatted postal codes are ""X0X#arguments.postalDivider#0X0""</li></ul>">
</cfif>
