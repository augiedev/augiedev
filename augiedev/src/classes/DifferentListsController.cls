public with sharing class DifferentListsController {

    public List<PieWedgeData> getPieData() {
    	
        List<PieWedgeData> data = new List<PieWedgeData>();
        Map<String, Integer> countryCount = new Map<String, Integer>();
        
        for (Account a : [SELECT Id, BillingCountry FROM Account WHERE BillingCountry != NULL]) {
        	if (countryCount.containsKey(a.BillingCountry)) {
        		Integer countryNumber = countryCount.get(a.BillingCountry) + 1;
        		countryCount.remove(a.BillingCountry);
        		countryCount.put(a.BillingCountry, countryNumber);
        	}
        	else {
        		countryCount.put(a.BillingCountry, 1);
        	}
        }
        
        for (String s : countryCount.keySet()) {
            data.add(new PieWedgeData(s, countryCount.get(s)));
            System.debug('s: ' + s);
            System.debug('Number: ' + countryCount.get(s));        	
        }
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}