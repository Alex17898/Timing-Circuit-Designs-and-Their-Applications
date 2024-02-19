#include <stdio.h>
#include <iostream>
using namespace std;
int x;
int SuccessiveApproximation(int target)
{
    int x = 128;
    uint8_t control = 64;
    int y = 607;
    for (int i = 0; i < 8; i++)
    {
        if ((control == 0) & (y > target))
        {
            x = x - 1;
        }
        else if (y > target)
        {
            x = x - control;
        }
        else
        {
            x = x + control;
        }
        control = control >> 1;
        y = (x << 1) + (13 * x >> 5) + 300;
    }
    return x;
}
int main()
{
    cout << "Taget=550 , x=" << SuccessiveApproximation(550) << endl;
    cout << "Taget=800 , x=" << SuccessiveApproximation(800) << endl;
    return 0;
}