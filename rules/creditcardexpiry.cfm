<cfif dateCompare( now(), dateAdd( "m", 1, dateAdd( "d", -1, arguments.value ) ) ) IS 1>
	<cfset arguments.message = "has already expired, please verify or select a newer card">
</cfif>
