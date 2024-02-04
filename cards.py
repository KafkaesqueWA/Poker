import random
from poker_hand import PokerHand
from itertools import combinations

def createSuit(s):
    suit = []

    for i in range(1,14):
        if i == 1:
            suit.append("A" + s)
        elif i <= 9:
            suit.append(str(i) + s)
        elif i == 10:
            suit.append("T" + s)
        elif i == 11:
            suit.append("J" + s)
        elif i == 12:
            suit.append("Q" + s)
        elif i == 13:
            suit.append("K" + s)

    return(suit)

def createDeck():
    deck = []

    for i in ["S","H","C","D"]:
        for j in createSuit(i):
            deck.append(j)

    random.shuffle(deck)
    return(deck)

def removeTop(deck):
    deck = deck[1:]
    return(deck)

def deal(deck,numP):
    playerHand = []
    flop = []
    turn = ""
    river = ""
    
    for i in range(0,numP):
        topTwo = deck[:2]
        playerHand.append(topTwo)
        deck = removeTop(deck)
        deck = removeTop(deck)
    deal.holdCards = playerHand

    for i in range(0,3):
        flop.append(deck[0])
        deck = removeTop(deck)
    deal.flop = flop

    turn = deck[0]
    deck = removeTop(deck)
    deal.turn = turn

    river = deck[0]
    deck = removeTop(deck)
    deal.river = river

    deal.deck = deck


def generate_combinations(objects, size):
    # Ensure that the size is valid
    if size > len(objects):
        raise ValueError("Size should be less than or equal to the length of the list")

    # Generate combinations
    all_combinations = list(combinations(objects, size))
    return all_combinations

# Example usage
#objects_list = [1, 2, 3, 4, 5, 6, 7]
#combination_size = 5

#result = generate_combinations(objects_list, combination_size)

# Print the result
#print("All combinations of size", combination_size, "from the given list:", result)


def hand(n):
    deal(createDeck(),n)

    board = []
    for i in deal.flop:
        board.append(i)
    board.append(deal.turn)
    board.append(deal.river)

    print(deal.holdCards)
    print(board)

    #test = [deal.holdCards[0][0],deal.holdCards[0][1],board[0],board[1],board[2],board[3],board[4]]
    #print(test) 
    #print(generate_combinations(test,5))

    #print(PokerHand(board).ranks)
    handStrengths = []
    for i in range(0,n):
        handStrengths.append([])
    
    count = 0
    for i in deal.holdCards:
        print()
        cards = [i[0],i[1],board[0],board[1],board[2],board[3],board[4]]
        print(i)
        rank = 0
        classification = "High Card"
        for j in generate_combinations(cards,5):
            hand = PokerHand(j).classify()
            if hand == "One Pair" and rank < 1:
                rank = 1
                classification = hand
            elif hand == "Two Pair" and rank < 2:
                rank = 2
                classification = hand
            elif hand == "Three of a Kind" and rank < 3:
                rank = 3
                classification = hand
            elif hand == "Straight" and rank < 4:
                rank = 4
                classification = hand
            elif hand == "Flush" and rank < 5:
                rank = 5
                classification = hand
            elif hand == "Full House" and rank < 6:
                rank = 6
                classification = hand
            elif hand == "Four of a Kind" and rank < 7:
                rank = 7
                classification = hand
            elif hand == "Straight Flush" and rank < 8:
                rank = 8
                classification = hand

            

        print(classification)




    

hand(5)
