{assign var="oUser" value=$oComment->getUser()}
{assign var="oVote" value=$oComment->getVote()}

<div id="comment_id_{$oComment->getId()}" class="comment {if !$oUserCurrent or ($oUserCurrent and !$oUserCurrent->isAdministrator())}not-admin{/if} {if $oComment->getDelete()} deleted{elseif $oUserCurrent and $oComment->getUserId()==$oUserCurrent->getId()} self{elseif $sDateReadLast<=$oComment->getDate()} new{/if}" >
{if !$oComment->getDelete() or $bOneComment or ($oUserCurrent and $oUserCurrent->isAdministrator())}
	<a name="comment{$oComment->getId()}" ></a>
	
	<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" width="40px" class="avatar" /></a>
	
	<div class="info">
		<span class="username"><a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a></span>
		<a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}">#</a>
		{if $oComment->getPid()}
			<span class="goto-comment-parent"><a href="#" onclick="ls.comments.goToParentComment({$oComment->getId()},{$oComment->getPid()}); return false;" title="{$aLang.comment_goto_parent}">↑</a></span>
		{/if}
		<span class="goto-comment-child"><a href="#" title="{$aLang.comment_goto_child}">↓</a></span>
		{if !$oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}
			<a href="#" class="delete" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_delete}</a>
		{/if}
		{if $oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}   										
			<a href="#" class="repair" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_repair}</a>
		{/if}
		<br />
		<div class="date">{date_format date=$oComment->getDate()}</div>
		{hook run='comment_action' comment=$oComment}
	</div>
	
	
	<div id="comment_content_id_{$oComment->getId()}" class="content">						
		{if $oComment->isBad()}
			<div style="display: none;" id="comment_text_{$oComment->getId()}">
				{$oComment->getText()}
			</div>
			 <a href="#" onclick="jQuery('#comment_text_{$oComment->getId()}').show();jQuery(this).hide();return false;">{$aLang.comment_bad_open}</a>
		{else}	
			{$oComment->getText()}
		{/if}
	</div>
		
		
	{if $oUserCurrent}
		<div class="actions">
			{if !$oComment->getDelete() and !$bAllowNewComment}<a href="#" onclick="ls.comments.toggleCommentForm({$oComment->getId()}); return false;" class="reply-link">{$aLang.comment_answer}</a>{/if}
		</div>
	{/if}
{else}				
	{$aLang.comment_was_delete}
{/if}
{if $oUserCurrent}
	<div class="comment-preview" id="comment_preview_{$oComment->getId()}" style="display: none;"><div class="comment-inner"><div class="content"></div></div></div>					
	<div class="reply" id="reply_{$oComment->getId()}" style="display: none;"></div>	
{/if}	
</div>