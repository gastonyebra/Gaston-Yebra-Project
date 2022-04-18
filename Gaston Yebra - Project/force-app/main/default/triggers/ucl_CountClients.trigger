trigger ucl_CountClients on Client__c (after insert, after delete) {

    if(Trigger.isInsert){
        //candidad de Clients +1
    }

    if(Trigger.isDelete){
        //candidad de Clients -1
    }

}