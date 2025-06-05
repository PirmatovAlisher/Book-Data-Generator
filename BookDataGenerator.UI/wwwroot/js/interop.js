function initInfiniteScroll(dotNetHelper) {
    const observer = new IntersectionObserver(async (entries) => {
        if (entries[0].isIntersecting) {
            await dotNetHelper.invokeMethodAsync('LoadMoreBooks');
        }
    }, { threshold: 1.0 });

    const sentinel = document.getElementById('scroll-sentinel');
    if (sentinel) observer.observe(sentinel);
}

window.downloadFile = (data) => {
    const blob = new Blob([new Uint8Array(data.byteArray)], 
        { type: data.contentType });
    const link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = data.fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
};