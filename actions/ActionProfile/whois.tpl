{include file='header.tpl' menu="profile"}

{assign var="oSession" value=$oUserProfile->getSession()}
{assign var="oVote" value=$oUserProfile->getVote()}
			
<div class="user-profile">
	<img src="{$oUserProfile->getProfileAvatarPath(100)}" alt="avatar" class="avatar" />
	<h3>{$oUserProfile->getLogin()}</h3>
	{if $oUserProfile->getProfileName()}
		{$oUserProfile->getProfileName()|escape:'html'}					
	{/if}										
</div>


{if $oUserProfile->getProfileSex()!='other' || $oUserProfile->getProfileBirthday() || ($oUserProfile->getProfileCountry() || $oUserProfile->getProfileRegion() || $oUserProfile->getProfileCity()) || $oUserProfile->getProfileAbout() || $oUserProfile->getProfileSite()}
	<h2>{$aLang.profile_privat}</h2>
	<table class="table">		
		{if $oUserProfile->getProfileSex()!='other'}
			<tr>
				<td>{$aLang.profile_sex}:</td>
				<td>
					{if $oUserProfile->getProfileSex()=='man'}
						{$aLang.profile_sex_man}
					{else}
						{$aLang.profile_sex_woman}
					{/if}
				</td>
			</tr>
		{/if}
			
		{if $oUserProfile->getProfileBirthday()}
			<tr>
				<td>{$aLang.profile_birthday}:</td>
				<td>{date_format date=$oUserProfile->getProfileBirthday() format="j F Y"}</td>
			</tr>
		{/if}
		
		{if ($oUserProfile->getProfileCountry()|| $oUserProfile->getProfileRegion() || $oUserProfile->getProfileCity())}
			<tr>
				<td>{$aLang.profile_place}:</td>
				<td>
				{if $oUserProfile->getProfileCountry()}
					<a href="{router page='people'}country/{$oUserProfile->getProfileCountry()|escape:'html'}/">{$oUserProfile->getProfileCountry()|escape:'html'}</a>{if $oUserProfile->getProfileCity()},{/if}
				{/if}						
				{if $oUserProfile->getProfileCity()}
					<a href="{router page='people'}city/{$oUserProfile->getProfileCity()|escape:'html'}/">{$oUserProfile->getProfileCity()|escape:'html'}</a>
				{/if}
				</td>
			</tr>
		{/if}
							
		{if $oUserProfile->getProfileAbout()}					
			<tr>
				<td>{$aLang.profile_about}:</td>
				<td>{$oUserProfile->getProfileAbout()|escape:'html'}</td>
			</tr>	
		{/if}
		
		{if $oUserProfile->getProfileSite()}
			<tr>
				<td>{$aLang.profile_site}:</td>
				<td>
					<a href="{$oUserProfile->getProfileSite(true)|escape:'html'}" rel="nofollow">
						{if $oUserProfile->getProfileSiteName()}
							{$oUserProfile->getProfileSiteName()|escape:'html'}
						{else}
							{$oUserProfile->getProfileSite()|escape:'html'}
						{/if}
					</a>
				</td>
			</tr>
		{/if}
	</table>
{/if}


<h2>{$aLang.profile_activity}</h2>
<table class="table">
	{if $aUsersFriend}
		<tr>
			<td>{$aLang.profile_friends}:</td>
			<td>
				{foreach from=$aUsersFriend item=oUser}        						
					<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $oConfig->GetValue('general.reg.invite') and $oUserInviteFrom}
		<tr>
			<td>{$aLang.profile_invite_from}:</td>
			<td>							       						
				<a href="{$oUserInviteFrom->getUserWebPath()}">{$oUserInviteFrom->getLogin()}</a>&nbsp;         					
			</td>
		</tr>
	{/if}
	
	{if $oConfig->GetValue('general.reg.invite') and $aUsersInvite}
		<tr>
			<td>{$aLang.profile_invite_to}:</td>
			<td>
				{foreach from=$aUsersInvite item=oUserInvite}        						
					<a href="{$oUserInvite->getUserWebPath()}">{$oUserInvite->getLogin()}</a>&nbsp; 
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogsOwner}
		<tr>
			<td>{$aLang.profile_blogs_self}:</td>
			<td>							
				{foreach from=$aBlogsOwner item=oBlog name=blog_owner}
					<a href="{router page='blog'}{$oBlog->getUrl()}/">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_owner.last}, {/if}								      		
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogAdministrators}
		<tr>
			<td>{$aLang.profile_blogs_administration}:</td>
			<td>
				{foreach from=$aBlogAdministrators item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{router page='blog'}{$oBlog->getUrl()}/">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogModerators}
		<tr>
			<td>{$aLang.profile_blogs_moderation}:</td>
			<td>
				{foreach from=$aBlogModerators item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{router page='blog'}{$oBlog->getUrl()}/">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}
	
	{if $aBlogUsers}
		<tr>
			<td>{$aLang.profile_blogs_join}:</td>
			<td>
				{foreach from=$aBlogUsers item=oBlogUser name=blog_user}
					{assign var="oBlog" value=$oBlogUser->getBlog()}
					<a href="{router page='blog'}{$oBlog->getUrl()}/">{$oBlog->getTitle()|escape:'html'}</a>{if !$smarty.foreach.blog_user.last}, {/if}
				{/foreach}
			</td>
		</tr>
	{/if}

	<tr>
		<td>{$aLang.profile_date_registration}:</td>
		<td>{date_format date=$oUserProfile->getDateRegister()}</td>
	</tr>	
	
	{if $oSession}				
		<tr>
			<td>{$aLang.profile_date_last}:</td>
			<td>{date_format date=$oSession->getDateLast()}</td>
		</tr>
	{/if}
</table>


{include file='footer.tpl'}