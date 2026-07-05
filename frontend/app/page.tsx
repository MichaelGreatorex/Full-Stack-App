type HealthResponse = {
  status?: string;
};

async function getHealthStatus() {
  const baseUrl = process.env.API_BASE_URL ?? "http://127.0.0.1:8000";

  try {
    const response = await fetch(`${baseUrl}/api/v1/health`, {
      cache: "no-store",
    });

    if (!response.ok) {
      return { label: "Backend unavailable", detail: `HTTP ${response.status}` };
    }

    const payload = (await response.json()) as HealthResponse;

    return {
      label: payload.status === "ok" ? "Backend healthy" : "Backend responded",
      detail: payload.status ?? "unknown",
    };
  } catch {
    return { label: "Backend unavailable", detail: "Could not reach FastAPI" };
  }
}

export default async function Home() {
  const health = await getHealthStatus();

  const stages = [
    {
      title: "Plan",
      description: "Define scope, API contracts, and development milestones.",
    },
    {
      title: "Build",
      description: "Implement frontend and backend features in parallel.",
    },
    {
      title: "Ship",
      description: "Validate quality and release through CI/CD automation.",
    },
  ];

  return (
    <main className="min-h-screen bg-[radial-gradient(circle_at_top,_#fff7ed_0%,_#fff_34%,_#f8fafc_100%)] text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-6xl flex-col px-6 py-6 sm:px-10 lg:px-12">
        <header className="flex items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.32em] text-amber-700">
              Full-Stack Template
            </p>
            <h1 className="mt-2 text-2xl font-semibold tracking-tight sm:text-3xl">
              Build and launch a modern web application.
            </h1>
          </div>
          <div className="rounded-full border border-emerald-200 bg-emerald-50 px-4 py-2 text-sm font-medium text-emerald-800">
            {health.label}: {health.detail}
          </div>
        </header>

        <section className="grid flex-1 gap-6 py-8 lg:grid-cols-[1.5fr_1fr] lg:items-start">
          <div className="space-y-6">
            <div className="rounded-[2rem] border border-slate-200 bg-white/85 p-8 shadow-[0_20px_80px_rgba(15,23,42,0.08)] backdrop-blur">
              <p className="text-sm font-semibold uppercase tracking-[0.28em] text-slate-500">
                Starter shell
              </p>
              <h2 className="mt-4 max-w-2xl text-4xl font-semibold tracking-tight sm:text-5xl">
                A generic foundation for your next product.
              </h2>
              <p className="mt-5 max-w-2xl text-lg leading-8 text-slate-600">
                This landing page is wired to the FastAPI health endpoint so the app
                can surface backend availability while feature work is in progress.
              </p>

              <div className="mt-8 flex flex-wrap gap-3 text-sm font-medium text-slate-700">
                <span className="rounded-full bg-slate-100 px-4 py-2">Next.js 16</span>
                <span className="rounded-full bg-slate-100 px-4 py-2">React 19</span>
                <span className="rounded-full bg-slate-100 px-4 py-2">FastAPI backend</span>
                <span className="rounded-full bg-slate-100 px-4 py-2">Server-side health check</span>
              </div>
            </div>

            <div className="grid gap-4 md:grid-cols-3">
              {stages.map((stage) => (
                <article
                  key={stage.title}
                  className="rounded-[1.5rem] border border-slate-200 bg-slate-950 p-5 text-slate-50 shadow-lg shadow-slate-950/10"
                >
                  <p className="text-xs font-semibold uppercase tracking-[0.3em] text-amber-300">
                    Step {stage.title}
                  </p>
                  <h3 className="mt-4 text-xl font-semibold">{stage.title}</h3>
                  <p className="mt-2 text-sm leading-6 text-slate-300">{stage.description}</p>
                </article>
              ))}
            </div>
          </div>

          <aside className="space-y-6 rounded-[2rem] border border-slate-200 bg-white/90 p-6 shadow-[0_20px_80px_rgba(15,23,42,0.08)] backdrop-blur">
            <div>
              <p className="text-sm font-semibold uppercase tracking-[0.28em] text-slate-500">
                Runtime signal
              </p>
              <h3 className="mt-3 text-2xl font-semibold tracking-tight">Backend health</h3>
              <p className="mt-3 text-sm leading-6 text-slate-600">
                The landing page fetches <span className="font-medium">/api/v1/health</span>
                from FastAPI on the server and renders the current status directly in the UI.
              </p>
            </div>

            <dl className="grid gap-4 rounded-[1.5rem] bg-slate-50 p-5">
              <div>
                <dt className="text-xs font-semibold uppercase tracking-[0.25em] text-slate-500">
                  API endpoint
                </dt>
                <dd className="mt-2 font-mono text-sm text-slate-900">GET /api/v1/health</dd>
              </div>
              <div>
                <dt className="text-xs font-semibold uppercase tracking-[0.25em] text-slate-500">
                  Current response
                </dt>
                <dd className="mt-2 text-sm text-slate-700">{health.detail}</dd>
              </div>
              <div>
                <dt className="text-xs font-semibold uppercase tracking-[0.25em] text-slate-500">
                  Next milestone
                </dt>
                <dd className="mt-2 text-sm text-slate-700">Implement your first end-to-end feature flow.</dd>
              </div>
            </dl>

            <div className="rounded-[1.5rem] border border-dashed border-slate-300 p-5 text-sm leading-6 text-slate-600">
              Use this page as a neutral project dashboard while you build domain-specific
              workflows.
            </div>
          </aside>
        </section>
      </div>
    </main>
  );
}
