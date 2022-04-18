import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ucl_UpdateData from '@salesforce/apex/ucl_UpdateData.ucl_UpdateData';

export default class UpdateButton extends LightningElement {
/*
    showErrorToast() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'Your data was unable to load',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }*/
/*
    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Your data was loaded sucessfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }*/

    handleButtonClick() {
        ucl_UpdateData()
            .then(exito => {
                const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Your data was loaded sucessfully',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
            })
            .catch(error => {
                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: 'Your data was unable to load',
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
            });
    }

}