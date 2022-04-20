trigger ucl_CountAdvisors on Legal_Advisor__c (after insert, after delete) {

    integer adv = [select count() from Legal_Advisor__c];


}