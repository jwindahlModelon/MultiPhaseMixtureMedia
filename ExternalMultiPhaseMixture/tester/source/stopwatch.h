#include "Windows.h"


class stopwatch {

    LARGE_INTEGER freq;
    LARGE_INTEGER tStart;

public:
    static stopwatch startNew() {
        stopwatch s = stopwatch();
        s.start();
        return s;
    }
    void start() {
        QueryPerformanceCounter(&(this->tStart));
    }
    long elapsed_ms() {
        return (long) this->elapsed(1000LL);
    }

private:
    stopwatch() {
        QueryPerformanceFrequency(&(this->freq));
    }
    long long elapsed(long long multiplier) {
        LARGE_INTEGER tEnd;
        QueryPerformanceCounter(&tEnd);
        long long elapsed_ticks = tEnd.QuadPart - this->tStart.QuadPart;
        return elapsed_ticks * multiplier / this->freq.QuadPart;
    }

};

