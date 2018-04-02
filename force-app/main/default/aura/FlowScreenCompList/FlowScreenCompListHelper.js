({
    loadComparableRentals : function(component) {

        var properties = [
            {Id: "1", Address__c: "121 N Halsted St", City__c: "Boston", Zip__c: "61633", Beds__c: 3, Baths__c: 2, Sqft__c: 800, Price__c: 565000, Days_Prediction__c: 7},
            {Id: "2", Address__c: "303 W Bittersweet Pl", City__c: "Boston", Zip__c: "60622", Beds__c: 3, Baths__c: 2, Sqft__c: 1250, Price__c: 550000, Days_Prediction__c: 8},
            {Id: "3", Address__c: "443 S Hermitage Ave", City__c: "Boston", Zip__c: "62633", Beds__c: 3, Baths__c: 2, Sqft__c: 1300, Price__c: 590000, Days_Prediction__c: 12},
            {Id: "4", Address__c: "350 S Lake Shore Dr", City__c: "Boston", Zip__c: "60622", Beds__c: 3, Baths__c: 2, Sqft__c: 1300, Price__c: 575000, Days_Prediction__c: 3},
            {Id: "5", Address__c: "66 E Roosevelet St", City__c: "Boston", Zip__c: "60533", Beds__c: 3, Baths__c: 2, Sqft__c: 1250, Price__c: 580000, Days_Prediction__c: 2},
            {Id: "6", Address__c: "720 S Archer Ave", City__c: "Boston", Zip__c: "60633", Beds__c: 3, Baths__c: 2, Sqft__c: 1500, Price__c: 560000, Days_Prediction__c: 12},
        ];

        component.set('v.properties', properties);

    }
})