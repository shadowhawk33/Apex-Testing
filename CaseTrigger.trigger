trigger CaseTrigger on Case (after insert) {
    if(Trigger.isAfter){
        if(trigger.isInsert){
            CaseTriggerHandler.sendEmailCase(trigger.new);
        }
    }
   
}
/* This is an apex trigger which runs Case object after insert,  */