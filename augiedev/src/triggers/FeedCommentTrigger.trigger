trigger FeedCommentTrigger on FeedComment (before insert, before update) {

    for (FeedComment fc : Trigger.New) {
        fc.CommentBody = fc.CommentBody + ' Comment from the Trigger';
        //fc.addError('You cannot comment!');
    }

}