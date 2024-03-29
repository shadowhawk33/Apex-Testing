import { LightningElement, api, wire } from 'lwc' ;
import getCOntactsBornAfter from '@salesforce/apex/ContactController.getContactsBornAfter';
export default class CallApexImperative extends LightningElement {
	@api minBirthDate;
	handleButoonClick() {
		getContactsBornAfter({ //imperative Apex call
			birthDate: this.minBirthDate
		})
			.then(Contacts => {
				//code to execute if related contacts are returned succesfully
			})
			.catch(error => {
				//code to execute if related contacts are not returned succesfully
			});
	}
}
