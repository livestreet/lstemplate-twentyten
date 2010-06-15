<div id="sidebar">
	<div class="block meta">
		<h2>Meta</h2>
		
		<ul>
			{if $oUserCurrent}
				<li><a href="{$oUserCurrent->getUserWebPath()}" class="username">{$oUserCurrent->getLogin()}</a></li>
				<li><a href="{router page='topic'}add/" class="create">{$aLang.topic_create}</a></li>
				{if $iUserCurrentCountTalkNew}
					<li><a href="{router page='talk'}" class="message-new" id="new_messages" title="{$aLang.user_privat_messages_new}">{$aLang.user_privat_messages} ({$iUserCurrentCountTalkNew})</a></li>
				{else}
					<li><a href="{router page='talk'}" id="new_messages">{$aLang.user_privat_messages} ({$iUserCurrentCountTalkNew})</a></li>
				{/if}
				<li><a href="{router page='settings'}profile/">{$aLang.user_settings}</a></li>
				<li><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}">{$aLang.exit}</a></li>
			{else}
				<li><a href="{router page='registration'}">{$aLang.registration_submit}</a></li>
				<li><a href="{router page='login'}">{$aLang.user_login_submit}</a></li>
			{/if}
		</ul>
	</div>
	
	
	{if isset($aBlocks.right)}
		{foreach from=$aBlocks.right item=aBlock}
			{if $aBlock.type=='block'}
				{insert name="block" block=`$aBlock.name` params=`$aBlock.params`}
			{/if}
			{if $aBlock.type=='template'}
				{include file=`$aBlock.name` params=`$aBlock.params`}
			{/if}
		{/foreach}
	{/if}
</div>