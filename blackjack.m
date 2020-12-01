load CardDeck

%init
global ShuffledDeck;
global deckNum;

ShuffledDeck = randperm(52);

deckNum = 5;
BookmakerCards = [ShuffledDeck(1),ShuffledDeck(2)];
PlayerCards = [ShuffledDeck(3),ShuffledDeck(4)];

fprintf("This is Dealer's card\n");
imshow([RedDeck{55},RedDeck{BookmakerCards(2:length(BookmakerCards))}]);
input("Please press any key to continue:\n");

fprintf("This is your card\n");
imshow([RedDeck{PlayerCards}]);

% Judge Black Jack
if(cardValue(PlayerCards) == 21) 
    if(cardValue(BookmakerCards) < 21)
        fprintf("Black Jack! You Win!\n");
    else
        fprintf("Equal!\n");
    end
    return
end

fprintf("Your total value is %d; ",cardValue(PlayerCards));
fprintf("The Dealer's total value is %d",cardValue(BookmakerCards(2:length(BookmakerCards))));
choice = printMenu(PlayerCards,BookmakerCards);

while (choice == 1)
    PlayerCards = [PlayerCards,ShuffledDeck(deckNum)];
    deckNum = deckNum + 1;
    fprintf("Your total value is %d; ",cardValue(PlayerCards));
    fprintf("The Dealer's total value is %d\n",cardValue(BookmakerCards));
    imshow([RedDeck{PlayerCards}]);
    if (cardValue(PlayerCards) > 21)
        fprintf("Busted!\n");
        break;
    end
    choice = printMenu(PlayerCards,BookmakerCards);
end

if(choice == 2)
    BookmakerCards = BookmakerOrder(BookmakerCards);
    fprintf("This is Dealer's Card. \n");
    imshow([RedDeck{BookmakerCards}]);
    if (cardValue(BookmakerCards)>21)
        fprintf("Dealer Busted! You win!\n");
    elseif (cardValue(BookmakerCards)>cardValue(PlayerCards))
        fprintf("Dealer wins!\n");    
    elseif (cardValue(BookmakerCards)<cardValue(PlayerCards))
        fprintf("You wins!\n");
    else
        fprintf("Equal!\n");
    end
end
    
%menu
%unfinished: UserCard is used to judge splite, bookmakerCard use to judge
%insurance 

function m = printMenu(userCard,bookmakerCard)
    fprintf("Your Option:\n");
    fprintf("1 Hit\n");
    fprintf("2 Stand\n");
    %fprintf("3 Double\n");
    %for i = 2:length(bookmakerCard)
    %    if mod(bookmakerCard(i),13)==1
    %        fprintf("4 Insurance\n");
    %        break;
    %    end
    %end
    m=input("Please input your choice: ");
end

% AI Bookmaker Order
function card = BookmakerOrder(card)
    global deckNum;
    global ShuffledDeck;
    
    if cardValue(card) < 17
        card = [card,ShuffledDeck(deckNum)];
        deckNum = deckNum + 1;
    end
end


% count values of card
function val = cardValue(cards)
    DeckValues = [-1 2:10 10 10 10 -1 2:10 10 10 10 -1 2:10 10 10 10 -1 2:10 10 10 10];
    countA = 0;
    val = 0;
    for i=1:length(cards)
        if DeckValues(cards(i)) ~= -1
            val = val+ DeckValues(cards(i));
        else
            countA = countA+1;
        end
    end
    
    if countA == 1
        
        if val+11>21
            val=val+1;
        elseif val+11<=21
            val = val+11;
        end
        
        elseif countA >1
            while countA > 1
                val = val + 1;
                countA =countA - 1;
            end
            if val+11>21
                val=val+1;
            elseif val+11<=21
                val = val+11;
            end
    end     
end


