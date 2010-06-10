{assign var="oUser" value=$oComment->getUser()}
{assign var="oVote" value=$oComment->getVote()}

<div class="comment-inner">
{if !$oComment->getDelete() or $bOneComment or ($oUserCurrent and $oUserCurrent->isAdministrator())}
	<a name="comment{$oComment->getId()}" ></a>
	
	<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" width="40px" class="avatar" /></a>
	
	<div class="info {if $oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}del{elseif $oUserCurrent and $oComment->getUserId()==$oUserCurrent->getId()}self{elseif $sDateReadLast<=$oComment->getDate()}new{/if}">
		<span class="username"><a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a> {$aLang.comment_says}:</span>
		<a href="#comment{$oComment->getId()}">#</a>
		{if $oComment->getPid()}
			<span class="goto-comment-parent"><a href="#comment{$oComment->getPid()}" onclick="return lsCmtTree.goToParentComment($(this));" title="{$aLang.comment_goto_parent}">↑</a></span>
		{/if}
		<span class="goto-comment-child hidden"><a href="#" onclick="return lsCmtTree.goToChildComment(this);" title="{$aLang.comment_goto_child}">↓</a></span>
		{if $oUserCurrent and !$bNoCommentFavourites}
			<!--<a href="#" onclick="lsFavourite.toggle({$oComment->getId()},this,'comment'); return false;" class="favorite {if $oComment->getIsFavourite()}active{/if}"></a>-->
		{/if}
		{if !$oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}
			<a href="#" class="delete" onclick="lsCmtTree.toggleComment(this,{$oComment->getId()}); return false;">{$aLang.comment_delete}</a>
		{/if}
		{if $oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}   										
			<a href="#" class="repair" onclick="lsCmtTree.toggleComment(this,{$oComment->getId()}); return false;">{$aLang.comment_repair}</a>
		{/if}
		<br />
		<div class="date">{date_format date=$oComment->getDate()}</div>
	</div>
	
	
	<div id="comment_content_id_{$oComment->getId()}" class="content">
		{if !$bOneComment and $oUserCurrent and $oComment->getUserId()!=$oUserCurrent->getId() and $sDateReadLast<=$oComment->getDate()}
			{literal}
			<script language="JavaScript" type="text/javascript">
				window.addEvent('domready', function() {
				{/literal}
					lsCmtTree.addCommentScroll({$oComment->getId()});
				{literal}
				});					
			</script>
			{/literal}
		{/if}							
		
		{if $oComment->isBad()}
			<div class="bad">{$oComment->getText()}</div>
		{else}	
			{$oComment->getText()}

			<br />
		{/if}
		
		{if $oUserCurrent and !$oComment->getDelete() and !$bAllowNewComment}
			<a href="javascript:lsCmtTree.toggleCommentForm({$oComment->getId()});" class="reply-link">{$aLang.comment_answer}</a>
		{/if}
		<a href="#" title="{$aLang.comment_collapse}/{$aLang.comment_expand}" class="folding" {if $bOneComment}style="display: none;"{/if}>{$aLang.comment_fold}</a>
	</div>
{else}				
	<div class="deleted">{$aLang.comment_was_delete}</div>
{/if}
</div>


{if $oUserCurrent}
	<div class="comment" id="comment_preview_{$oComment->getId()}" style="display: none;"><div class="comment-inner"><div class="content"></div></div></div>					
	<div class="reply" id="reply_{$oComment->getId()}" style="display: none;"></div>	
{/if}	


<div class="comment-children" id="comment-children-{$oComment->getId()}">
{if $bOneComment}</div>{/if}