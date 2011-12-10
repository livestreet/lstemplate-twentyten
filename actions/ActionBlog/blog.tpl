{include file='header.tpl' menu='blog'}
{assign var="oUserOwner" value=$oBlog->getOwner()}
{assign var="oVote" value=$oBlog->getVote()}



{if $oUserCurrent and $oUserCurrent->isAdministrator()}
	<form id="blog_delete_form" class="blog-delete-form" action="{router page='blog'}delete/{$oBlog->getId()}/" method="POST">
		<a href="#" class="close jqmClose"></a>
	
		<p>{$aLang.blog_admin_delete_move}</p>
		<p><select name="topic_move_to">
			<option value="-1">{$aLang.blog_delete_clear}</option>
			{if $aBlogs}
				<optgroup label="{$aLang.blogs}">
					{foreach from=$aBlogs item=oBlogDelete}
						<option value="{$oBlogDelete->getId()}">{$oBlogDelete->getTitle()}</option>
					{/foreach}
				</optgroup>
			{/if}
		</select></p>
		
		<input type="hidden" value="{$LIVESTREET_SECURITY_KEY}" name="security_ls_key" />
		<input type="submit" value="{$aLang.blog_delete}" />
	</form>
{/if}

<div class="blog">
	<h2><img src="{$oBlog->getAvatarPath(24)}" alt="avatar" class="avatar" /> {$oBlog->getTitle()|escape:'html'}</h2>
	
	<ul class="actions">
		<li><a href="{router page='rss'}blog/{$oBlog->getUrl()}/" class="rss">Rss</a></li>
		{if $oUserCurrent and $oUserCurrent->getId()!=$oBlog->getOwnerId()}
			<li><a href="#" onclick="ls.blog.toggleJoin(this,{$oBlog->getId()}); return false;">{if $oBlog->getUserIsJoin()}{$aLang.blog_leave}{else}{$aLang.blog_join}{/if}</a></li>
		{/if}
		{if $oUserCurrent and ($oUserCurrent->getId()==$oBlog->getOwnerId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() )}
			<li>
				<a href="{router page='blog'}edit/{$oBlog->getId()}/" title="{$aLang.blog_edit}" class="edit">{$aLang.blog_edit}</a></li>
				{if $oUserCurrent->isAdministrator()}
					<li><a href="#" title="{$aLang.blog_delete}" id="blog_delete_show" class="delete">{$aLang.blog_delete}</a>
				{else}
					<a href="{router page='blog'}delete/{$oBlog->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.blog_delete}" onclick="return confirm('{$aLang.blog_admin_delete_confirm}');" >{$aLang.blog_delete}</a>
				{/if}
			</li>
		{/if}
	</ul>
	
	<p>{$oBlog->getDescription()|nl2br}</p>	
</div>


{if $bCloseBlog}
	{$aLang.blog_close_show}
{else}
	{include file='topic_list.tpl'}
{/if}


{include file='footer.tpl'}