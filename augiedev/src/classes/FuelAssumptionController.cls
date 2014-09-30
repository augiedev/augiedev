public with sharing class FuelAssumptionController {
	
	public FuelAssumptionController() {}
	
	@RemoteAction
	public static string createFuelConsumptionRecord(string litres, string kilometres) {
		System.debug('in createFuel method');
		Fuel_Consumption__c fc = new Fuel_Consumption__c();
		fc.Litres_Tanked__c = Double.valueOf(litres);
		fc.Kilometres_Driven__c = Double.valueOf(kilometres);
		fc.Consumption_Date__c = Date.today();
		insert(fc);
		return fc.Id;
	}
	
	public List<Data> getLineChartData() {
		List<Data> chartData = new List<Data>();
		for (Fuel_Consumption__c fc : [SELECT Consumption_Date__c, Kilometres_per_Litre__c, Litres_Tanked__c FROM Fuel_Consumption__c ORDER BY Name DESC LIMIT 10]) {
			chartData.add(new Data(fc.Consumption_Date__c, fc.Kilometres_per_Litre__c, fc.Litres_Tanked__c));
		}
		return reorderList(chartData);
	}
	
	private List<Data> reorderList(List<Data> chartData) {
		List<Data> reorderedChartData = new List<Data>();
		for (Integer i = chartData.size(); i > 0; i--) {
			reorderedChartData.add(chartData[i-1]);
		}
		return reorderedChartData;
	}
		
	// Wrapper Class - Data
	public class Data {
		public String consumptionDate { get; set; }
		public Decimal kilometresPerLitre { get; set; }
		public Decimal litresTanked { get; set; }
		
		public Data (Date consumptionDate, Decimal kilometresPerLitre, Decimal litresTanked) {
			this.consumptionDate = String.valueOf(consumptionDate).substring(0, 10);
			this.kilometresPerLitre = kilometresPerLitre;
			this.litresTanked = litresTanked;
		}
	}	 
}