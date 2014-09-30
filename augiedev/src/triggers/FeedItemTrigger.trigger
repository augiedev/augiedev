trigger FeedItemTrigger on FeedItem (before insert, before update) {

    for (FeedItem fi : Trigger.new) {
        fi.Body = fi.Body + ' from the Trigger';
        // fi.addError('Post is not allowed');
    }

}