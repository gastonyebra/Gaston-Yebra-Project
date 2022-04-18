public with sharing class ucl_ScheduleUpdate implements Schedulable {
    public void execute(SchedulableContext ctx) {

        ucl_UpdateData.ucl_UpdateData();

    }
}

