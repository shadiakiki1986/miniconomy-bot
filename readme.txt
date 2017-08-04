Bot for miniconomy.com that I wrote in 2011

General:
Automating my trading on www.miniconomy.com
I can download all prices from the market and search them super fast.
I can automate the auction.
I can calculate costs of production based on market-available products (if only 2 screwdrivers at 10 and 3 at 7, and if I need 4, then it shows me that i'll need 2x10+3x7)
etc.


Related documents:
mcdb.sql


Other documents:
cookie.txt


D/b:
1st design was text files
	StockPrices.txt
	ProductPrices_*/
	ProductPrices_List_*.txt
	cashHistory.txt
2nd design is mysql d/b
	The perl code already inserts and selects from the d/b

Instructions
A. Setting up the environment: Instructions to log into miniconomy on both firefox and via my perl scripts by using a common cookie:
1. go to Edit/Preferences/Delete individual cookies/search for miniconomy
2. delete all available cookies
3. Login to miniconomy on firefox
4. look at the new cookie and copy its phpsession
5. paste it in cookie.txt (make sure you use cookie.txt.bkp as a template)
6. Edit MCAutomate.pm to put the uesrname and password you use
7. In ProductPrices_Retrieve.pl, set the correct city name and type in the street names to navigate
* Note that the expiry date of the cookie needs to be taken care of

C. Trading in the market
1. Navigate in the browser to desired city and download market products and prices while you're in each city.
	* It's ideal to go to all cities and download all market data.
	* note that this script automatically determines which city you're in and updates only the entries in the d/b for this city
	perl ProductPrices_Retrieve.pl
	perl ProductPrices_Retrieve.pl Pumps
2. Show list of product names available
	perl ProductPrices_Unique.pl
3. Find best price of a product
	perl ProductPrices_Show.pl Pumps
4. Calculate, from the downloaded market prices, the cost of production of X items at a rate of Y items per production
	perl ProductPrices_ProductionCosts.pl Pumps 3 1
5. Send a limit order for the auction
	perl Auction_Get.pl 300

----------------------
Doing
* make a mysql database and save the information there. This way I have a more solid basis
* echo "perl '/home/shadi/experimental/MCAutomate/Stock_AutoInvest.pl' > '/home/shadi/experimental/MCAutomate/Stock_AutoInvest.pl'.out "|at 21:01 03/12/2011
** > atq


Todo: Mysql db
* script that updates the db from the website
** should be able to navigate between different cities and within the city to crawl between streets witihout repeating them
** Note that updating the db would cost me ISH to travel between the cities. For this, I can haev a parameter that says "travel to other cities or not"
* script that collects all the auction items: statistics will help identify the most frequent item so I can specialize in it


Todo
* KeepMachineAlive.pl Should seaerch for best available price in the market instead of having hard-coded 1 shop
* RetrievePrices.pl should not need the names of hte streets
* Need script that will retrieve the best price of each product among all the cities (probably a script that automatically sails also?)
* script that will buy stuff for me: simply give it the city name, the street name, and the shop name. Of course, I will need a d/b of where the ports are.
* script that will buy out all (e.g.) Gold from a market, so I can sell it in my own shop at the highest possible price (max price allowable by miniconomy)
* script that returns the highest possible price in miniconomy
* script that will identify products that are missing in cities (check section below entitled "Markets missing products")
* script that watches the auction, finds the shop with the best deal (using the latest entries in the db), makes sure that what it's using is not out-of-date, and waits till the price hits the margins I want and sells
* script that does the exim for me (I can run it every evening)
* script that buys me the cheapest of a product (in the current city or in the whole economy)
* script that identifies which markets are missing which products
* specialize in a product that goes on auction a lot, make a script that produces it and sells it right before the price hits the minimum price available in markets (as long as it is profitable). Is there a cap on this? (per day like exim)


Todo: manual things
* buy lots, search for resources, upgrade skills


Markets missing products
* Cashington didn't have Gold or Diamond drill
* Centropolis doesn't have pumps


