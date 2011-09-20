<!--- must contain "@" AND "." --->
<cfif NOT find( "@", arguments.value )>
	<cfset arguments.message = "is invalid without a ""@"" symbol"><!--- , it should be like: fred@domain.com --->
<cfelseif NOT find( ".", arguments.value )>
	<cfset arguments.message = "is invalid without a period ""."""><!--- it should be like: fred@domain.com --->
<!--- only contain letters, numbers, underscores, hyphens, periods, "@" symbol --->
<cfelseif NOT reFindNoCase( "^[""'](?:[A-Z0-9-]+ ){1,4}[""'] <[A-Z0-9._%'+-]+@(?:[A-Z0-9-]+\.)+(?:[A-Z]{2}|aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel)>$", arguments.value )>
	<cfif arguments.mutable>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9._ @&<>%'+-]", "", "all" )>
	</cfif>
	<cfset arguments.message = "is invalid, it should be like: fred@domain.com">
</cfif>

