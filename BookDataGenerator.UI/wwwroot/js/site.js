let observer;

// Initialize infinite scroll
export function initInfiniteScroll(dotNetHelper) {
    observer = new IntersectionObserver(async (entries) => {
        if (entries[0].isIntersecting) {
            await dotNetHelper.invokeMethodAsync('LoadMoreBooks');
        }
    }, { threshold: 1.0 });

    const sentinel = document.getElementById('scroll-sentinel');
    if (sentinel) observer.observe(sentinel);
}

// Disconnect observer
export function disconnectInfiniteScroll() {
    if (observer) {
        observer.disconnect();
    }
}

// Scroll to element
export function scrollToElement(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}

// File download helper
export function downloadFile(data) {
    const blob = new Blob([new Uint8Array(data.byteArray)],
        { type: data.contentType });
    const link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = data.fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}