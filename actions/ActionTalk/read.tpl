{include file='header.tpl'}
{include file='menu.talk.tpl'}

{assign var="oUser" value=$oTalk->getUser()}


<div class="topic">
	<h2 class="title">{$oTalk->getTitle()|escape:'html'}</h2>

	<ul class="actions">
		<li class="delete"><a href="{router page='talk'}delete/{$oTalk->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" onclick="return confirm('{$aLang.talk_inbox_delete_confirm}');" class="delete">{$aLang.talk_inbox_delete}</a></li>
	</ul>

	<div class="content">
		{$oTalk->getText()}
	</div>

	<div class="info">
		<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a> |
		{date_format date=$oTalk->getDate()}
	</div>
</div>

{assign var="oTalkUser" value=$oTalk->getTalkUser()}

{if !$bNoComments}
{include
	file='comment_tree.tpl'
	iTargetId=$oTalk->getId()
	sTargetType='talk'
	iCountComment=$oTalk->getCountComment()
	sDateReadLast=$oTalkUser->getDateLast()
	sNoticeCommentAdd=$aLang.topic_comment_add
	bNoCommentFavourites=true
}
{/if}
			
			
{include file='footer.tpl'}