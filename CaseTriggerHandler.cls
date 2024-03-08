public class CaseTriggerHandler {
    public static void sendEmailCase(list<Case> caseList){
        List<Id> caseIdsToSendEmail = new List<Id>();
        list<CaseComment> addCaseCommentList = new list<CaseComment>();
        system.debug('inside');
        for (Case newCase : caseList) {
            if (newCase.Origin == 'Web' && newCase.Description != null) {
                caseIdsToSendEmail.add(newCase.OwnerId);
                
                // Create a new Case Comment
                CaseComment newComment = new CaseComment();
                newComment.ParentId = newCase.Id; // Associate the comment with the Case
                newComment.CommentBody = 'A new Case was created via web with the following description: ' + newCase.Description;
                addCaseCommentList.add(newComment);
                // Insert the comment directly
            }
            if(!addCaseCommentList.isEmpty()){
                insert addCaseCommentList;
            }
        }
        
        // Send email to Case Owners
        if (!caseIdsToSendEmail.isEmpty()) {
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            list<User> ownerEmails = new list<User>();
            ownerEmails = [select id , SenderEmail from User where id in : caseIdsToSendEmail];
            system.debug('ownerEmails'+ownerEmails);
            for (User ownerId : ownerEmails) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTargetObjectId(ownerId.id);
                system.debug('ownerId'+ownerId);
                email.setSubject('New Case Created via Web');
                email.setPlainTextBody('A new Case was created via web. Please review it.');
                email.saveAsActivity = false;
                emails.add(email);
            }
            Messaging.sendEmail(emails);
        }
        
    }
    
}