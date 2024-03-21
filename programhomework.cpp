#include <iostream>
#include <vector>
#include <sstream>

using namespace std;

void quicksort(vector<int>& arr,int left,int right) {
    if(left < right) {
        int i = left , j = right + 1 , p = arr[left];
        do {
            do {
                i++;
            }while(arr[i] < p);
            do{
                j--;
            }while(arr[j] > p);
            if(i < j) {
            	swap(arr[i],arr[j]);
			}
        }while(i < j);
        swap(arr[left],arr[j]);
        quicksort(arr,left,j-1);
        quicksort(arr,j+1,right);
    }
}

void merhesort() {

}

void heapsort() {

}

int main () {
	vector<int> arr;
	string input;
	getline(cin, input);
	stringstream ss(input);
    int num;
    while (ss >> num) {
        arr.push_back(num);
    }
    cout<<endl<<"your string : ";
    for(int num : arr) {
    	cout<<num<<" ";
	}
	cout<<endl<<"sort string : ";
	quicksort(arr,0,arr.size()-1);
	for(int num : arr) {
    	cout<<num<<" ";
	}
    return 0;
}
