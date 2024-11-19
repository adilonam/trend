//+------------------------------------------------------------------+
//|                                                        trend.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
CTrade trade ;
// Define input parameters
input int pip = 500 ;



struct Situation
  {
   int               type;    // Order type (OP_BUY or OP_SELL)
   bool              onTrade;
  };

Situation mySituation = {0, false};


// Define global variables
double amaBuffer[];

// Define OnInit function
int OnInit()
  {


   return(INIT_SUCCEEDED);
  }

// Define OnTick function
void OnTick()
  {

   absurde_trade("EURUSD");
 //  absurde_trade("GBPUSD");
 //absurde_trade("USDJPY");

  }



















// Function to generate a random number between 0 and 1
double getRandomNumber(int maxNumber)
  {
   int randomValue = MathRand(); // Generate a random integer value
   double result = NormalizeDouble(randomValue / 32767.0*maxNumber , 6); // Convert to a floating-point number between 0 and 1
   return result;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int positionTotalSymbol(string symbol)
  {
   int count = 0;
   for(int i = 0; i < PositionsTotal(); i++)
     {

      if(PositionGetSymbol(i) == symbol)
        {
         count += 1;
        }
     }

   return count ;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void absurde_trade(string symbol)
  {


   int digits = SymbolInfoInteger(symbol, SYMBOL_DIGITS);

   double ask = NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_ASK),digits) ;

   double bid = NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_BID), digits) ;

   double point = SymbolInfoDouble(symbol, SYMBOL_POINT);



   double signalIn = 0;


   if(getRandomNumber(ask) > getRandomNumber(ask))
      signalIn = 1;
   else
      signalIn = -1;




// Execute trading orders based on signals
if( positionTotalSymbol(symbol) == 0){
double gap_sl = pip  * point  ; 
double gap_tp = pip  * point  ; 
 if(signalIn == 1)
     {

      double sl =  ask - gap_sl;
      double tp = ask +gap_tp ;
      trade.Buy(0.1, symbol, ask,sl, tp,NULL);

     }
   else
      if(signalIn == -1)
        {

         double sl = bid +gap_sl ;
         double tp = bid -gap_tp ;

         trade.Sell(0.1, symbol, bid, sl, tp,NULL);

        }

}
}



void OnTrade()
{

 Print("----------Trade----------------");
  
      ulong ticket = HistoryDealGetTicket( 0);
      double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
 Print("----------Trade----------------" , ticket);
      if (profit != 0.0)
      {
         string symbol = HistoryDealGetString(ticket, DEAL_SYMBOL);
         if (profit > 0)
            Print("----------Trade on ", symbol, " is a WIN! Profit: ", profit);
         else
            Print("--------------Trade on ", symbol, " is a LOSS! Loss: ", -profit);

 
      }
   
}
//+------------------------------------------------------------------+
